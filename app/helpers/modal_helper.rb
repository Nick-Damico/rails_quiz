module ModalHelper
  def hidden_field_for_modal(form, object)
    field = "#{object.class.name.downcase}_id"
    form.hidden_field(field, value: object.id)
  end

  def model_for_modal(object)
    class_name = object.class.name

    if class_name == "Deck"
      StudyPlanDeck.new(deck: object)
    elsif class_name == "Quiz"
      StudyPlanQuiz.new(quiz: object)
    end
  end

  def modal_radio_btn_disabled?(radio_btn, object)
    class_name = object.class.name

    if class_name == "Deck"
      radio_btn.object.decks.include?(object)
    elsif class_name == "Quiz"
      radio_btn.object.quizzes.include?(object)
    end
  end

  def url_for_modal(object)
    class_name = object.class.name

    if class_name == "Deck"
      study_plan_decks_path
    elsif class_name == "Quiz"
      study_plan_quizzes_path
    end
  end
end
