# frozen_string_literal: true

class FormsController < ApplicationController
  def new
    @form = current_user.forms.new
  end

  def create
    @form = current_user.forms.new(form_params)
    if @form.save
      redirect_to @form
    else
      render "new"
    end
  end

  def show
    @form = current_user.forms.find(params[:id])
  end

  def edit
    @form = current_user.forms.find(params[:id])
  end

  def update
    @form = current_user.forms.find(params[:id])
    if @form.update(form_params)
      redirect_to @form, notice: "フォーム内容を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    form = current_user.forms.find(params[:id])
    form.destroy
    redirect_to root_path, notice: "フォームを削除しました"
  end

  private
    def form_params
      params.require(:form).permit(:name, :domain, :redirect_url)
    end
end
