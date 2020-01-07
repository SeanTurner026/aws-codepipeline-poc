import boto3

session = boto3.Session()
client = session.client('ssm', 'us-east-1')

response = client.put_parameter(
    Name='turner',
    Description='string',
    Value='sean',
    Type='SecureString',
    KeyId='alias/aws/ssm',
    Overwrite=True,
    # AllowedPattern='string',
    Tier='Standard',
    # Policies='string'
)
