defmodule Trelix.Resources.Follow do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "follows"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    create_timestamp :created_at
  end

  relationships do
    belongs_to :follower, Trelix.Resources.User, attribute_writable?: true, allow_nil?: false
    belongs_to :followed, Trelix.Resources.User, attribute_writable?: true, allow_nil?: false
  end

  identities do
    identity :unique_edge, [:follower_id, :followed_id]
  end

end
