defmodule MorphicPro.OrganizationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MorphicPro.Organizations` context.
  """

  @doc """
  Generate a organization.
  """
  def organization_fixture(attrs \\ %{}) do
    {:ok, organization} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> MorphicPro.Organizations.create_organization()

    organization
  end
end
