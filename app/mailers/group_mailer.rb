class GroupMailer < ApplicationMailer
  def send_mail(mail_title, mail_content, group_users, group_id)
    @group = Group.find(group_id)
    @mail_title = mail_title
    @mail_content = mail_content
    mail bcc: group_users.pluck(:email), subject: mail_title
  end
end
