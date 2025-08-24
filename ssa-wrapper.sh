#!/bin/bash
# Wrapper pour HPE SSA Web GUI avec port fixe

LOGFILE=/var/log/ssa-wrapper.log
SSA_BIN=/opt/smartstorageadmin/ssa/bin/ssa
FIXED_PORT=8443

# Kill anciens process éventuels
pkill -f "$SSA_BIN -local"
pkill -f "socat TCP-LISTEN:$FIXED_PORT"

# Lancer SSA en arrière-plan
$SSA_BIN -local > $LOGFILE 2>&1 &
SSA_PID=$!

# Attendre un peu pour qu'il démarre
sleep 3

# Récupérer le port aléatoire
PORT=$(ss -tlnp | grep ssaclient | awk '{print $4}' | sed 's/.*://')

if [ -z "$PORT" ]; then
    echo "Impossible de trouver le port SSA !" | tee -a $LOGFILE
    kill $SSA_PID
    exit 1
fi

echo "SSA lancé sur 127.0.0.1:$PORT (proxifié sur :$FIXED_PORT)" | tee -a $LOGFILE

# Lancer un proxy socat sur port fixe
socat TCP-LISTEN:$FIXED_PORT,fork TCP:127.0.0.1:$PORT &
SOCAT_PID=$!

# Attendre la fin de SSA
wait $SSA_PID
kill $SOCAT_PID
