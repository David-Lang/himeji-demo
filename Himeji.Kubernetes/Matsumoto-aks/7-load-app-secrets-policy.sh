
- !policy
  id: demo-app
  body:
    # Define users
  - !user devops-admin

     # Define a groups of members 
  - !group devops
  
  - !grant
    roles:
    - !group devops
    members:
    - !user devops-admin
    - !host /himeji-app

  - &variables
   - !variable slack_botduty_webhook
   - !variable dockerhub_cred
   - !variable github_cred

  - !permit
    # Give permissions to the human user to update the secret and fetch the secret.
    role: !user devops-admin
    privileges: [read, update, execute]
    resource: *variables

  - !permit
    role: !group devops
    privilege: [ read, execute ]
    resource: *variables
