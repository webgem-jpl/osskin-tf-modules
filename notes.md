
terraform state backend
- DynamoDB cost could probably be reduce below 5
- To create the backend, you need to start with terraform_state_backend deploy this
Then add the backend module and terraform init to migrate the state. Then add the other modules.
- possible to set MFA on delete
- might want to have script to start a new stage with its on terraform state, S3 and lock.
- S3 and DynamoDB Table in backend cant be referenced by variables
- its possible to have one global locking system and lock every project with a different path.
  it is not recommended since it create coupling. We recommend to create the backend in a separate stack
  to prevent to destroy the terraform state accidentally.
- One backend stack for a whole project can work assuming all keys of terraform state are differents.

VPC
- can use only 2 AZ to reduce cost on network interface

Should we have one VPC or one VPC per environment?

ECS TASK DEFINITION
- volume not implemented

What if supposed to be the service role for FARGATE ?

new ARN format Opt-in
- Error: InvalidParameterException: The new ARN and resource ID format must be enabled to add tags to the service. Opt in to the new format and try again.

Maybe keep the unauthenticate path

Maybe create a ALIAS to private target group, instead of a target group for public

Maybe create the ECR separately from the service stack...

It creates unused target group

maybe turn ALB deletion_protection_enabled


task definition should wait until loadbalancer is created.
- Error: InvalidParameterException: The target group with targetGroupArn arn:aws:elasticloadbalancing:us-east-1:978111875057:targetgroup/osskin-staging-api-ecs-public/056a32df031703b0 does not have an associated load balancer.
	status code: 400, request id: efe3edbe-34b7-40e1-a9a7-aa4b26737dcb "osskin-staging-api"

  on ../../../terraform-modules/ecs_alb_service_task/main.tf line 182, in resource "aws_ecs_service" "ignore_changes_task_definition":
 182: resource "aws_ecs_service" "ignore_changes_task_definition" {


and when deleting:

   Error: Error deleting Target Group: ResourceInUse: Target group 'arn:aws:elasticloadbalancing:us-east-1:978111875057:targetgroup/ok-staging-canary-private/79d3e92e2a2b3285' is currently in use by a listener or a rule
   	status code: 400, request id: 22ae9abc-c470-11e9-9c84-d92b1cca57a2

   Error: Error deleting Target Group: ResourceInUse: Target group 'arn:aws:elasticloadbalancing:us-east-1:978111875057:targetgroup/ok-staging-canary-public/1eb1a342a1497ab4' is currently in use by a listener or a rule
   	status code: 400, request id: 22ae250c-c470-11e9-8d35-cd50ff940582
