class NotesController < ApplicationController
  before_action :set_note, only: %i[ show edit update destroy ]

 

  # POST /notes or /notes.json
  def create
    params[:note][:user_id] = current_user.id
    @note = Note.new(note_params)
    respond_to do |format|
      if @note.save
        format.html { redirect_to @note.track, notice: "Note was successfully created." }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { redirect_to @note.track, alert: "Note cannot be empty" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    url = track_url(@note.track)
    if @note.user == current_user
      @note.destroy
      respond_to do |format|
        format.html { redirect_to url, notice: "Note was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to url, alert: "You can't delete that note"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:note, :track_id, :user_id)
    end
end
