module Admin::TranslationsHelper
  def translation_percent(language)
    translated = Translation.count(:conditions => ['globalize_translations.language_id = ? AND text IS NOT NULL', language.id])
    total = Translation.count(:conditions => ['globalize_translations.language_id = ?', language.id])
    translated * 100 / total
  end
end
