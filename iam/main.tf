resource "aws_iam_user" "user" {
  name = "eks-user"
}

resource "aws_iam_access_key" "key" {
  user = aws_iam_user.user.name
}

resource "aws_iam_group" "group" {
  name = "eks-group"
}

resource "aws_iam_user_group_membership" "team" {
  user = aws_iam_user.user.name
  groups = [aws_iam_group.group.name]
}

resource "aws_iam_group_policy_attachment" "policy" {
  group      = aws_iam_group.group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}