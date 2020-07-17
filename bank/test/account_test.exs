defmodule AccountTest do
  use ExUnit.Case

  test "initial balance eq 0" do
    {:ok, pid} = Account.start_link()

    assert 0 == Account.get_balance(pid)
  end

  test "depositing money must change the balance by 10" do
    {:ok, pid} = Account.start_link()

    Account.deposit(pid, 10)

    assert 10 == Account.get_balance(pid)
  end

  test "withdraw money reduces balance by 5" do
    {:ok, pid} = Account.start_link()

    Account.withdraw(pid, 5)

    assert -5 == Account.get_balance(pid)

    Account.deposit(pid, 10)

    assert 5 == Account.get_balance(pid)

    Account.withdraw(pid, 5)

    assert 0 == Account.get_balance(pid)
  end
end
