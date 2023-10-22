#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

source env/Scripts/activate
python main.py
read -p "Press enter to continue..."