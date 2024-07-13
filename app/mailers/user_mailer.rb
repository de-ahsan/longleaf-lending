class UserMailer < ApplicationMailer
  def termsheet_email(loan_request, pdf)
    attachments['termsheet.pdf'] = pdf
    mail(to: loan_request.email, subject: 'Your Term Sheet', body: 'Please find attached your term sheet.')
  end
end
