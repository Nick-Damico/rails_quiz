module Questions::ChoicesHelper
  def nested_dom_id(choice_form)
    return unless choice_form.object.is_a?(Question::Choice)

    choice_form.object.persisted? ? choice_form.object : "choice_new_#{choice_form.index}"
  end
end
