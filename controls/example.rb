# encoding: utf-8
# copyright: 2017, The Authors

control "aws-1" do
  impact 0.7
  title 'Checks the machine is running'

  describe aws_ec2_instance(name: 'VJ') do
    it { should be_running }
  end
end

control "aws-2" do
  impact 0.7
  title 'Checks the machine is running'

  describe aws_ec2_instance(name: 'VJ-windows') do
    it { should be_running }
  end
end

control "Users that have a password but do not have MFA enabled" do
  impact 0.7
  describe aws_iam_users.where { has_console_password and not has_mfa_enabled } do
    it { should_not exist }
  end
end

control "Do not allow access keys older than 90 days" do
  impact 1.0
  describe aws_iam_access_keys.where { created_days_ago > 90 } do
    it { should_not exist }
  end
end