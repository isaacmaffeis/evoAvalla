# EvoAvalla

## Installation

To start using EvoAvalla, you need to have [Docker Desktop](https://www.docker.com/products/docker-desktop) installed on your machine.

Make sure you have it installed and then clone the repository:

```shell
git clone https://github.com/isaacmaffeis/evoAvalla.git
```

> **Note:** Currently, this project only works on **Windows** machines because it uses a batch file (`exec.bat`)
> that can only be executed in a Command Prompt (CMD).

## How to Start

Follow these steps to run the project:

1. **Open Docker Desktop:**

    Open and run Docker Desktop.

2. **Prepare Your Input File:**

    Place the .asm file you want to process in the input folder of the cloned repository.

3. **Run the Project:**

    Open a CDM terminal and navigate to the root of the cloned repository folder:
    ```cmd
    cd path/to/cloned/repository
    ```
    Run the following command to execute the project:
    ```cmd
    exec.bat
    ```
    At this point the application will run and provide the output in the `./output` folder.

## System Architecture

EvoAvalla is structured as a series of microservices built on Docker:

1. [**asmetal2java**](https://github.com/isaacmaffeis/asmetal2java): Converts the .asm input file into a Java application.
2. [**evoservice**](https://github.com/isaacmaffeis/evoservice): Generates a Junit test suite fot the newly created Java application using EvoSuite.
3. [**javaToAvalla**](https://github.com/isaacmaffeis/javaToAvalla): Converts the Junit test suite into the Avalla format.

These projects are built and integrated into EvoAvalla using a GitHub Action CI pipeline.
This pipeline automates the building of Docker images for each project,
making them available for use in EvoAvalla via the `docker-compose` file.


   
