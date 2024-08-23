#!/bin/bash

echo "# gen_evosuite.sh"
echo "## Generating test suite with EvoSuite"

echo "Running evosuite-1.0.6 on registroDiCassa.RegistroDiCassa..."
java -jar evosuite-1.0.6.jar -class org.evoservice.registroDiCassa.RegistroDiCassa

echo "gen_evosuite.sh process completed."
