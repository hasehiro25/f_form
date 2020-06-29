# frozen_string_literal: true

class FormsController < ApplicationController
  def new
    @form = current_user.forms.new
  end

  def create
    @form = current_user.forms.new(form_params)
    if @form.save
      redirect_to @form, notice: "新しいフォームを作成しました"
    else
      render "new"
    end
  end

  def show
    @form = set_form
  end

  def edit
    @form = set_form
  end

  def update
    @form = set_form
    if @form.update(form_params)
      redirect_to @form, notice: "フォーム内容を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    form = set_form
    form.destroy
    redirect_to root_path, notice: "フォームを削除しました"
  end

  private
    def set_form
      current_user.forms.find(params[:id])
    end

    def form_params
      params.require(:form).permit(:name, :domain, :redirect_url, :recaptcha_status)
    end
end
