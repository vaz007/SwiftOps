{
  aws ec2 describe-vpcs --endpoint-url=http://localhost:4566 --region='us-east-1';
  aws ec2 describe-subnets --endpoint-url=http://localhost:4566 --region='us-east-1';
  aws ec2 describe-route-tables --endpoint-url=http://localhost:4566 --region='us-east-1';
  aws ec2 describe-internet-gateways --endpoint-url=http://localhost:4566 --region='us-east-1';
  aws ec2 describe-network-acls --endpoint-url=http://localhost:4566 --region='us-east-1';
  aws ec2 describe-security-groups --endpoint-url=http://localhost:4566 --region='us-east-1';
} > vpc_configuration.json
