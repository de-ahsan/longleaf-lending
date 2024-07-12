class LoanRequestService
  attr_reader :loan_request, :session, :params

  def initialize(session, params = {})
    @session = session
    @params = params
    @loan_request = LoanRequest.new(session[:loan_request_params])
    @loan_request.current_step = session[:loan_request_step] || '1'
  end

  def process_step
    session[:loan_request_params].deep_merge!(params.to_h) if params.present?
    loan_request.attributes = session[:loan_request_params]

    if loan_request.valid?
      if params[:back_button]
        loan_request.previous_step
      elsif loan_request.last_step?
        loan_request.save
      else
        loan_request.next_step
      end
      session[:loan_request_step] = loan_request.current_step
    end
    loan_request
  end

  def reset_session
    session[:loan_request_step] = session[:loan_request_params] = nil
  end
end
