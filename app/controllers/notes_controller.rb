class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_note, only: %i[show edit update destroy]
  def index
    @notes = Note.all
  end

  def show
  end

  def new
    @note = current_user.notes.build
  end

  def create
    @note = current_user.notes.build(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to note_path(@note), notice: 'Note created successfully' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to note_path(@note), notice: 'Note updated successfully' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy
  
    respond_to do |format|
      format.html { redirect_to notes_path, notice: 'Note was removed successfully' }
    end
  end

  private

  def note_params
    params.require(:note).permit(:user_id, :title, :content)
  end

  def find_note
    @note = Note.find(params[:id])
  end
end
