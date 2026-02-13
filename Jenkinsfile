pipeline {
agent any
environment {
AWS_DEFAULT_REGION = 'us-east-1'
}
stages {
stage('Checkout') {
steps {
echo 'Checking out code...'
// Code is already checked out by Jenkins
sh 'ls -la'
}
}
stage('Terraform Init') {
steps {
echo 'Initializing Terraform...'
dir('terraform') {
sh 'terraform init'
}
}
}
stage('Terraform Validate') {
steps {
echo 'Validating Terraform configuration...'
dir('terraform') {
sh 'terraform validate'
}
}
}
stage('Terraform Plan') {
steps {
echo 'Planning Terraform changes...'
dir('terraform') {
sh 'terraform plan -out=tfplan'
}
}
}
stage('Approval') {
steps {
echo 'Waiting for manual approval...'
input message: 'Do you want to apply this plan?',
ok: 'Apply'
}
}
stage('Terraform Apply') {
steps {
echo 'Applying Terraform changes...'
dir('terraform') {
sh 'terraform apply -auto-approve tfplan'
}
}
}
stage('Show Outputs') {
steps {
echo 'Terraform outputs:'
dir('terraform') {
sh 'terraform output'
}
}
}
}
post {
success {
echo 'Pipeline completed successfully!'
}
failure {
echo 'Pipeline failed!'
}
always {
echo 'Cleaning up...'
dir('terraform') {
sh 'rm -f tfplan'
}
}
}
}