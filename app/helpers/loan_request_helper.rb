module LoanRequestHelper
  def progress_bar_width(current_step)
    case current_step.to_i
    when 1
      '16%'
    when 2
      '32%'
    when 3
      '48%'
    when 4
      '64%'
    when 5
      '80%'
    when 6
      '100%'
    else
      '0%'
    end
  end

  def step_class(step, current_step)
    step.to_i == current_step.to_i ? 'font-bold text-green-500' : ''
  end

  def render_steps(current_step, total_steps = 6)
    (1..total_steps).map do |step|
      content_tag(:span, "Step #{step}", class: step_class(step, current_step))
    end.join.html_safe
  end

  def render_step_form(form, current_step)
    render partial: "loan_requests/steps/step#{current_step}", locals: { form: form }
  end
end
