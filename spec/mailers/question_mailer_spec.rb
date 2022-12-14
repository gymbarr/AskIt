# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionMailer, type: :mailer do
  describe '#notify_subscriber_about_new_question_in_category' do
    subject(:mail) do
      described_class.with(question: question,
                           user: user,
                           categories: categories,
                           categories_name: categories_name)
                     .notify_subscriber_about_new_question_in_category
                     .deliver_now
    end

    let(:question) { create :question, :with_categories }
    let(:categories) { question.categories }
    let(:categories_name) { categories.map(&:name).join(', ') }
    let(:user) { create :user }

    it 'sends email to the receiver emailname' do
      expect(mail.to[0]).to eq(user.email)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    context 'when locale is en' do
      before do
        I18n.locale = :en
      end

      it 'renders the subject' do
        expect(mail.subject)
          .to eq("#{"New question in the #{categories_name} category!".truncate(40)} | AskIt")
      end

      it 'renders the body' do
        expect(mail.text_part.body.encoded)
          .to match(/There is a new questions/)
        expect(mail.html_part.body.encoded)
          .to match(/There is a new questions/)
      end
    end

    context 'when locale is ru' do
      before do
        I18n.locale = :ru
      end

      let(:user) { create :user, locale: 'ru' }

      it 'renders the subject' do
        expect(mail.subject)
          .to eq("#{"Новый вопрос в категории #{categories_name}!".truncate(40)} | AskIt")
      end

      it 'renders the body' do
        expect(mail.text_part.body.encoded)
          .to match(/Появился новый вопрос в категории/)
        expect(mail.html_part.body.encoded)
          .to match(/Появился новый вопрос в категории/)
      end
    end
  end
end
