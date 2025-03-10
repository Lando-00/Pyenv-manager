# Pyenv-manager
![Windows](https://img.shields.io/badge/Made%20for-Windows-blue?logo=windows&logoColor=white)

- A Simple Python Virtual Environment Manager for Windows
- Created by: Lovanto George
- `pyenv.cmd` is a Windows batch script that simplifies managing Python virtual environments in Command Prompt. It allows you to list, activate, deactivate, and delete virtual environments with simple commands.
## 🛠 Set up
### Step 1: Download the Script
Clone this repository or download `pyenv.cmd` manually.

Clone using Git:

```sh
git clone https://github.com/Lando-00/Pyenv-manager.git
```
or download pyenv.cmd directly.

### Step 2: Move pyenv.cmd to a Directory in PATH
To use pyenv **globally** in Command Prompt, move pyenv.cmd to a folder that is in your system PATH.

- Open System Properties (Win + R, type sysdm.cpl, press Enter).
- Go to the Advanced tab → Click Environment Variables.
- Under System variables, find Path, click Edit.
    - Click New and add:
    - <Path to root folder where you have the `pyenv.cmd` file>

> Alternatively you can Move the `pyenv.cmd` to any folder that is under the path variables

- Click OK to save.
- Restart Command Prompt for changes to take effect.

Now, you can call **pyenv** from any directory.

### Step 3: Set up root folder for python envs
- Open System Properties (Win + R, type sysdm.cpl, press Enter).
- Go to the Advanced tab → Click Environment Variables.
- Under User Variables
    - Click New and add:
    - Variable Name: **Python_Env_Dir**
    - Variable Value: <Path to root folder where you have all the Python Envs>

## 🎯 Usage
### **List** Available Virtual Envs
```cmd
pyenv list
```
Example Output:
```cmd
Listing Python virtual environments...
--- --- --- --- --- --- --- --- --- --- --- ---
"my_project_env"
"data_science_env"
"test_env"
--- --- --- --- --- --- --- --- --- --- --- ---
```
### **Activate** a Virtual Environment
```cmd
pyenv activate <env_name>
```
- After activation, your command prompt will change to:
```cmd
(my_project_env) C:\Users\usern>
```
### **Deactivate** the Current Virtual Environment
```cmd
pyenv deactivate
```
- or manually specify an environment to deactivate
```cmd
pyenv deactivate <env_name>
```
### **Delete** a Virtual Environment
```cmd
pyenv delete <env_name>
```
⚠️ Warning: This permanently deletes the environment.

## 🛠 Configuration
By default `pyenv.cmd` looks for the envs in system variables `%Python_Env_Dir%` </br>
> In set up make sure to label and set the root folder for environments correctly. 

- If you want to change the system variable name that the script looks at, edit the `pyenv.cmd` manually.
    - At the top of the script change the following
```cmd
set "ENV_DIR=%Python_Env_Dir%"
```

## 📜 License
This project is open-source and available under the MIT License.

---

## Happy Coding!
Now, managing Python virtual environments (with Python) on Windows is easier than ever with pyenv.cmd! 🚀🔥