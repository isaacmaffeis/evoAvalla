echo "#EvoAvalla"
echo "## "

echo "Searching the .asm input file"
set "input_dir=.\input"
set "input_file="
for %%f in ("%input_dir%\*.asm") do (
    set "input_file=%%f"
    goto :found
)
:found
if "%input_file%"=="" (
    echo "Error: No .asm file found in %input_dir%. Stopping execution."
    exit /b
)
for %%f in ("%input_file%") do set "input_file_no_ext=%%~nf"

echo "Found %input_file_no_ext%.asm in %input_dir% with path %input_file%"
move "%input_file%" ".\services\asmetal2java\input"

echo "Updating the images..."
docker compose pull

echo "Starting the containers..."
docker compose up -d

echo "Running asmetal2java..."
docker compose run --rm asmetal2java -input "./input/%input_file_no_ext%.asm"
move ".\services\evoservice\input\StepFunctionArgs.txt" ".\services\javaToAvalla\input"

echo "Running evoservice..."
docker compose run --rm evoservice ./scripts/main.sh

echo "Running javatoavalla"
docker compose run --rm javatoavalla -input "./input/%input_file_no_ext%_ASM_ESTest.java" -clean true

echo "stop and remove containers"
docker compose down