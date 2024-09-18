echo "#EvoAvalla"
echo "## "

set /p input_file="Digit the asm file name <asmName>.asm (without .asm): "

if not exist .\input\%input_file%.asm (
    echo "Error: File %input_file% not exists. Stopping the execution..."
    exit /b
)

move ".\input\%input_file%.asm" ".\asmetal2java\input"

echo "Updating the images..."
docker compose pull -q

echo "Starting the containers..."
docker compose up -d --build

echo "Cleaning folders..."
del /Q .\evoservice\target\*
for /d %%i in (.\evoservice\target\*) do rmdir /S /Q "%%i"

echo "Running asmetal2java..."
docker compose run --rm asmetal2java -input "./input/%input_file%.asm"
move ".\evoservice\input\StepFunctionArgs.txt" ".\javaToAvalla\input"

echo "Running evoservice..."
docker compose run --rm evoservice python3 ./scripts/retrieve_input.py

docker compose run --rm evoservice ./scripts/mvn_setup.sh

docker compose run --rm evoservice python3 scripts/gen_evosuite_sh.py -criterion LINE:BRANCH -Dminimize=true -Dassertion_strategy=all

docker compose run --rm evoservice ./scripts/gen_evosuite.sh

docker compose run --rm evoservice ./scripts/tests.sh

echo "Running javatoavalla"
docker compose run --rm javatoavalla -input "./input/%scenario_file%_ASM_ESTest.java" -clean true

echo "stop and remove containers"
docker compose down