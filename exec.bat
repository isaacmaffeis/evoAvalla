echo "#EvoAvalla"
echo "## "

echo "Updating the images..."
docker compose pull -q

echo "Starting the containers..."
docker compose up -d --build

echo "Cleaning folders..."
del /Q .\evoservice\target\*
for /d %%i in (.\evoservice\target\*) do rmdir /S /Q "%%i"

echo "Running asmetal2java..."
docker compose run --rm asmetal2java -input ./input/RegistroDiCassa.asm

echo "Running evoservice..."
docker compose run --rm evoservice python3 ./scripts/retrieve_input.py

docker compose run --rm evoservice ./scripts/mvn_setup.sh

docker compose run --rm evoservice python3 scripts/gen_evosuite_sh.py

docker compose run --rm evoservice ./scripts/gen_evosuite.sh

docker compose run --rm evoservice ./scripts/tests.sh

echo "stop and remove containers"
docker compose down