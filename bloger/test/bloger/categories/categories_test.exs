defmodule Bloger.CategoriesTest do
  use Bloger.DataCase
  alias Bloger.Categories
  alias Bloger.Categories.Category

  describe "create_category/1" do
    test "with valid data must craete a new category" do
      params = %{title: "My title"}

      assert {:ok, category} = Categories.create_category(params)

      assert category.title == params.title
    end

    test "with invalid data must return an error" do
      params = %{title: ""}

      {:error, changeset_errors} = Categories.create_category(params)

      assert "can't be blank" in errors_on(changeset_errors).title
      assert {:error, %Ecto.Changeset{}} = Categories.create_category(params)
    end
  end

  describe "list_categories" do
    test "return a list of categories" do
      category = Bloger.Repo.insert!(%Category{title: "My title"})
      categories = Categories.list_categories()

      ids = Enum.map(categories, fn(c) -> c.id end)
      assert category.id in ids
    end
  end
end

#     test "list_partner_metrics/0 returns all partner_metrics" do
#       record = partner_metric_fixture()
#       records = Metrics.list_partner_metrics()
#       ids = Enum.map(records, fn(record) -> record.id end)
#       assert record.id in ids
#     end

#     test "create_partner_metric/1 with valid data creates a partner_metric" do
#       partner = Factory.insert(:partner)
#       valid_attrs = Map.put(@valid_attrs, :partner_id, partner.id)
#
#       assert {:ok, partner_metric} = Metrics.create_partner_metric(valid_attrs)
#
#       assert partner_metric.id != nil
#       assert partner_metric.company_id == @valid_attrs.company_id
#       assert partner_metric.type == @valid_attrs.type
#       assert partner_metric.value == Decimal.new(@valid_attrs.value)
#       assert partner_metric.date == DateTime.to_naive(@valid_attrs.date)
#       assert partner_metric.unit == @valid_attrs.unit
#     end
#
#     test "create_partner_metric/1 without partner id returns ecto changeset" do
#       assert {:error, %Ecto.Changeset{}} = Metrics.create_partner_metric(@valid_attrs)
#     end
#
#     test "create_partner_metric/1 with invalid data returns error changeset" do
#       partner = Factory.insert(:partner, %{})
#       invalid_attrs = Map.put(@invalid_attrs, :partner_id, partner.id)
#       assert {:error, %Ecto.Changeset{}} = Metrics.create_partner_metric(invalid_attrs)
#     end

# defmodule PartnerResaleship.MetricsTest do
#   use Partnership.DataCase
#
#   import SaaSInternalAPI.TestHelpers.Query.Pagination
#
#   alias Partnership.Factory
#   alias Partnership.Repo
#   alias Partnership.Metrics
#   alias Partnership.Metrics.Partner, as: PartnerMetric
#
#   def partner_metric_fixture(attrs \\ %{}) do
#     Factory.insert(:partner_metric, attrs)
#   end
#
#   describe "partner_metrics" do
#     @valid_attrs %{
#       company_id: Ecto.UUID.generate(),
#       type: :mrr,
#       value: 200,
#       date: Timex.now,
#       unit: "BRL"
#     }
#
#     @invalid_attrs %{type: nil}
#
#     test "list_partner_metrics/0 returns all partner_metrics" do
#       record = partner_metric_fixture()
#       records = Metrics.list_partner_metrics()
#       ids = Enum.map(records, fn(record) -> record.id end)
#       assert record.id in ids
#     end
#
#     test "list_partner_metrics/1 with company_id returns all partner_metrics from company" do
#       first_company_id = Ecto.UUID.generate()
#       second_company_id = Ecto.UUID.generate()
#
#       record = partner_metric_fixture(%{company_id: first_company_id})
#       record_from_other_company = partner_metric_fixture(%{company_id: second_company_id})
#
#       records = Metrics.list_partner_metrics(%{"company_id" => first_company_id})
#       ids = Enum.map(records, fn(record) -> record.id end)
#       assert record.id in ids
#       refute record_from_other_company.id in ids
#     end
#
#     test "list_partner_metrics/1 with partner_customer_id returns all partner_metrics from partner" do
#       company_id = Ecto.UUID.generate()
#       partner = Factory.insert(:partner, %{company_id: company_id})
#
#       record = partner_metric_fixture(%{company_id: company_id, partner: partner})
#       record_from_other_partner = partner_metric_fixture(%{company_id: company_id})
#
#       records = Metrics.list_partner_metrics(%{"company_id" => company_id, partner_customer_id: partner.customer_id})
#       ids = Enum.map(records, fn(record) -> record.id end)
#       assert record.id in ids
#       refute record_from_other_partner.id in ids
#     end
#
#     test "list_partner_metrics/1 with type returns all partner_metrics from type" do
#       company_id = Ecto.UUID.generate()
#       metrics_net_revenue_churn_percentage = Factory.insert(:partner_metric, %{
#         company_id: company_id, type: :net_revenue_churn_percentage
#       })
#       metrics_logo_churn_percentage = Factory.insert(:partner_metric, %{
#         company_id: company_id, type: :logo_churn_percentage
#       })
#       metrics_activation_percentage = Factory.insert(:partner_metric, %{
#         company_id: company_id, type: :activation_percentage
#       })
#
#       records = Metrics.list_partner_metrics(%{"company_id" => company_id, type: "net_revenue_churn_percentage"})
#       ids = Enum.map(records, fn(record) -> record.id end)
#       assert metrics_net_revenue_churn_percentage.id in ids
#       refute metrics_logo_churn_percentage.id in ids
#       refute metrics_activation_percentage.id in ids
#
#       records = Metrics.list_partner_metrics(%{"company_id" => company_id, type: :logo_churn_percentage})
#       ids = Enum.map(records, fn(record) -> record.id end)
#       assert metrics_logo_churn_percentage.id in ids
#       refute metrics_net_revenue_churn_percentage.id in ids
#       refute metrics_activation_percentage.id in ids
#
#       records = Metrics.list_partner_metrics(%{"company_id" => company_id, type: :activation_percentage})
#       ids = Enum.map(records, fn(record) -> record.id end)
#       assert metrics_activation_percentage.id in ids
#       refute metrics_logo_churn_percentage.id in ids
#       refute metrics_net_revenue_churn_percentage.id in ids
#     end
#
#     test "list_partner_metrics/1 with page and page_size should paginate" do
#       Factory.insert_list(2, :partner_metric)
#       records = PartnerMetric |> Repo.all # Reload to clear preloads
#       assert_paginate_query(Metrics, :list_partner_metrics, records)
#     end
#
#     test "list_partner_metrics/1 default order should be by inserted_at asc" do
#       now = Timex.now
#       second_object = partner_metric_fixture(%{inserted_at: Timex.shift(now, hours: -1)})
#       first_object = partner_metric_fixture(%{inserted_at: Timex.shift(now, hours: -2)})
#       objects = Metrics.list_partner_metrics()
#       ids = Enum.map(objects, fn(object) -> object.id end)
#       assert Enum.at(ids, 0) == first_object.id
#       assert Enum.at(ids, 1) == second_object.id
#     end
#
#     test "list_partner_metrics/1 should order according to params" do
#       second_object = partner_metric_fixture(%{value: 2})
#       first_object = partner_metric_fixture(%{value: 1})
#       objects = Metrics.list_partner_metrics(%{order: [value: :asc]})
#       ids = Enum.map(objects, fn(object) -> object.id end)
#       assert Enum.at(ids, 0) == first_object.id
#       assert Enum.at(ids, 1) == second_object.id
#
#       objects = Metrics.list_partner_metrics(%{order: [value: :desc]})
#       ids = Enum.map(objects, fn(object) -> object.id end)
#       assert Enum.at(ids, 0) == second_object.id
#       assert Enum.at(ids, 1) == first_object.id
#     end
#
#     test "get_partner_metric!/1 returns the partner_metric with given id" do
#       record = partner_metric_fixture()
#       assert Metrics.get_partner_metric!(record.id).id == record.id
#     end
#
#     test "get_partner_metric_by_company_id!/2 returns the partner_metric with given id" do
#       first_company_id = Ecto.UUID.generate()
#       second_company_id = Ecto.UUID.generate()
#
#       record = partner_metric_fixture(%{company_id: first_company_id})
#
#       assert Metrics.get_partner_metric_by_company_id!(first_company_id, record.id).id == record.id
#       assert_raise Ecto.NoResultsError, fn ->
#         Metrics.get_partner_metric_by_company_id!(second_company_id, record.id)
#       end
#     end
#
#     test "get_partner_metric_by_company_id/1 with partner_customer_id filter filters by partner" do
#       partner = Factory.insert(:partner)
#       record = partner_metric_fixture(%{partner: partner})
#
#       assert Metrics.get_partner_metric_by_company_id!(
#         record.company_id,
#         record.id,
#         %{"partner_customer_id" => partner.customer_id}
#       ).id == record.id
#     end
#
#     test "create_partner_metric/1 with valid data creates a partner_metric" do
#       partner = Factory.insert(:partner)
#       valid_attrs = Map.put(@valid_attrs, :partner_id, partner.id)
#
#       assert {:ok, partner_metric} = Metrics.create_partner_metric(valid_attrs)
#
#       assert partner_metric.id != nil
#       assert partner_metric.company_id == @valid_attrs.company_id
#       assert partner_metric.type == @valid_attrs.type
#       assert partner_metric.value == Decimal.new(@valid_attrs.value)
#       assert partner_metric.date == DateTime.to_naive(@valid_attrs.date)
#       assert partner_metric.unit == @valid_attrs.unit
#     end
#
#     test "create_partner_metric/1 without partner id returns ecto changeset" do
#       assert {:error, %Ecto.Changeset{}} = Metrics.create_partner_metric(@valid_attrs)
#     end
#
#     test "create_partner_metric/1 with invalid data returns error changeset" do
#       partner = Factory.insert(:partner, %{})
#       invalid_attrs = Map.put(@invalid_attrs, :partner_id, partner.id)
#       assert {:error, %Ecto.Changeset{}} = Metrics.create_partner_metric(invalid_attrs)
#     end
#   end
# end
