# Exercise 8 — Hello World Jenkins Job

## Objective
Create a Jenkins Freestyle job that pulls a shell script from GitHub and prints `Hello, Jenkins!`.

## Steps
1. Create `hello-world.sh`:
   ```bash
   #!/bin/bash
   echo "Hello, Jenkins!"
   ```
   ![Script in VS Code](images/1.png)

2. Commit and push it to [my DevOps-Assignment repository](https://github.com/prashantkr102004-ui/DevOps-Assignment).

   ![Script on GitHub](images/2.png)

3. In Jenkins: **New Item → HelloWorld → Freestyle project**.

   ![Job configuration](images/3.png)

4. **Source Code Management → Git**: repository URL `https://github.com/prashantkr102004-ui/DevOps-Assignment.git`, branch `*/main`.
   **Build Steps → Execute shell**:
   ```bash
   cd exercise-8
   bash hello-world.sh
   ```
   ![Git and build step](images/4.png)

5. **Save → Build Now** and open the console output.

   ![Successful build](images/5.png)
   > 📸 Screenshot: console showing `Hello, Jenkins!` and `Finished: SUCCESS`.

## Result
The job checked out the repo, ran the script and printed `Hello, Jenkins!` with `Finished: SUCCESS`.
