use Amnesia
require Exquisite

defdatabase Dwitter.Database do
  deftable Dweet, [:id, :content, :in_reply_to_id], type: :ordered_set do
    @type t :: Dweet[id: integer, content: String.t, in_reply_to_id: integer]

    def in_reply_to(self) do
      Dweet.read(self.in_reply_to_id)
    end

    def replies(self) do
      Dweet.where(in_reply_to_id == self.id).values
    end
  end
end

defmodule AmnesiaTest do
  use ExUnit.Case
  use Dwitter.Database

  test "saving dweets" do
    Amnesia.transaction! do
      dweet = Dweet[id: 1, content: 'some things happened']
      dweet.write
    end

    assert 'some things happened' == Dweet.read!(1).content
  end

  test "finding replies" do
    Amnesia.transaction! do
      dweet = Dweet[id: 1, content: 'some things happened.']
      dweet.write
      reply = Dweet[id: 2, content: 'tell me more.', in_reply_to_id: 1]
      reply.write
    end

    Amnesia.transaction! do
      assert 'some things happened.' == Dweet.read!(2).in_reply_to.content
      [reply] = Dweet.read!(1).replies
      assert 'tell me more.' == reply.content
    end
  end

  setup_all do
    Amnesia.Test.start
  end

  teardown_all do
    Amnesia.Test.stop
  end

  setup do
    Dwitter.Database.create!

    :ok
  end

  teardown do
    Dwitter.Database.destroy!

    :ok
  end
end
