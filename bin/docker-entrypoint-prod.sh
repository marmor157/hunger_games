#!/bin/sh

bin/hunger_games eval "HungerGames.Release.migrate"

exec "$@"
