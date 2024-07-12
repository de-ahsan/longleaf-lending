class LoanRequestsController < ApplicationController
  before_action :set_loan_request, only: %i[show update]

  def new
    session[:loan_request_params] ||= {}
    @loan_request = LoanRequest.new(session[:loan_request_params])
    @loan_request.current_step = session[:loan_request_step] || '1'
  end

  def create
    loan_request_service = LoanRequestService.new(session, loan_request_params)
    @loan_request = loan_request_service.process_step

    if @loan_request.new_record?
      render :new
    else
      loan_request_service.reset_session
      redirect_to root_path, notice: "Loan request was successfully created."
    end
  end

  private

  def set_loan_request
    @loan_request = LoanRequest.find(params[:id])
  end

  def loan_request_params
    params.require(:loan_request).permit(:address, :loan_term, :purchase_price, :repair_budget, :arv, :first_name, :last_name, :email, :phone)
  end
end
