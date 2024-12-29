# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MorphicPro.Repo.insert!(%MorphicPro.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

if Application.get_env(:morphic_pro, :env) == :dev do
  MorphicPro.Users.User
  |> MorphicPro.Repo.delete_all()

  MorphicPro.Users.register_user(%{email: "admin@asdf.com", password: "asdfasdfasdfasdf"})
  |> case do
    {:ok, user} -> user
    _ -> nil
  end
  |> MorphicPro.Users.change_user_admin(%{"admin" => true})

  1..50
  |> Enum.each(fn i ->
    MorphicPro.Users.register_user(%{email: "user#{i}@asdf.com", password: "asdfasdfasdfasdf"})
    |> case do
      {:ok, user} -> user
      _ -> nil
    end
  end)
end
