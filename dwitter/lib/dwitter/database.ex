use Amnesia
require Exquisite

defdatabase Dwitter.Database do
  deftable Dweet, [:id, :content, :in_reply_to_id], type: :ordered_set do
    @type t :: Dweet[id: integer, content: String.t, in_reply_to_id: integer]

    def in_reply_to(self) do
      Dweet.read(self.in_reply_to_id)
    end

    def replies(self) do
      Dweet.where(:in_reply_to_id == self.id).values
    end
  end
end


