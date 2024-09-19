# EvolOsProject
source code of EvolOs
 --- dev branch ---

 ## Branch System

* **Main** : Main branch, containing production/stable code.

    *  **Dev** : Development branch where completed features are merged. The code remains to be tested before moving to the main branch.

        * **Feature\_$number assigned on Notion$\_$name given on Notion to the feature$** : Branch dedicated to main features (e.g., distribution, software, etc.).

            * **F\_$number assigned on Notion$\_$sub-features for the feature$** : Branch dedicated to sub-features of main features.

                * **F\_$number assigned on Notion$\_fix\_$sub-features for the feature$** : Branch dedicated to fixing a sub-feature. It is created in case of an issue and merged back once resolved.

 ## Commit System
Use the following tags in your commit messages to quickly indicate the action performed:

`ADD -` : When adding a new feature  
`UPDATE -` : When modifying an existing feature  
`DELETE -` : When deleting a feature  
`OPTI -` : When optimizing code without functional changes  
`MERGE -` : When performing a merge

To remove unnecessary logs or test features, please use the amend command:  
`git commit --amend && git push --force`  
In case of an error or to refine a commit same command.

  