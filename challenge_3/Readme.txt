# This read me file helps you to create the infrastructure in aws.
1. Make sure the chanllenge_3 directory has these seven files (main.tf, backend.tf, nginx.sh.tpl, myproject.sh, versions.tf, tfversions_readme and Readme.txt)

  * Main.tf has the configuration of (ec2, keypairs, security groups and their ports)
  * backend.tf has the configuration of the (s3 bucket and dynamodb)
  * nginx.sh.tpl has the userdata script that runs on ec2 to create html page on nginx on port 8080 and change the hostname to pinky1.
    -This can be tested coping the public ip and pasting on chrome with http,replace with your public ip in the given example(eg:http://44.203.93.98:8080/)
    -This will change the host name to pinky1.
    -This will store the output of each command that run on userdata in pinky1_log file in the location (var/log/pinky1_log)
  * myproject.sh is the script file that will configure aws profile and perform the terraform init plan and apply comands to deploy the infrastructure and also configure the s3 backend for terraform tf storage.

2 To deploy the infrastructure run the myproject.sh in the challenge_3 directory  
./myproject.sh 

3. The commandline will promt you to enter the access keys of aws, please enter the access keys from cloudguru sandbox
Enter the access key and secret key and region as us us-east-1

# now terraform initializes by itself to get all the plugins needed. 
# terraform gives you the plan of resources that are going create.
# terraform apply will be performed and resources will be created.

# now provider.tf file will be created in the challenge_3 directory in which the terraform remote backend configuration will be there.
4. Now it will ask you to enter the acess_key and secret_key, Please enter the same keys that you entered in step 2 from cloudguru sandbox.

# now it will re-initialize Terraform with backend configuration.
5. Now it will ask you to enter YES or NO, if you enter YES the terraform.tf state file created in the local machine will be moved to remote s3 bucket backend.
   If you enter NO, the statefile will not moved to remote s3 backend.
xxxxxxxxxxx please enter YES as we want to store statefile in s3 remote bakend xxxxxxxxxxx

6. The private_key with name pinky1.pem will stored in home/user/keys folder. The user can be any nmae on your system.
- now go to the keys folder "home/user/keys"

- run chmod 400 <name of the key.pem> , It will change the permissions of the file with read access only.
- for our case run (chmod 400 pinky1.pem)
- now run this command to loginto the instance (ssh -i "pinky1.pem" ubuntu@ec2-54-158-129-18.compute-1.amazonaws.com)
- ssh -i "<name of the privatekey.pem>" <user name of ec2>@ec2-<public ipv4 of ec2>.compute-1.amazonaws.com, this can also be found on aws console,
go to ec2 instance id , click on connect, click on ssh client, at the bottom , on the top of note message , we can find this command.

  

