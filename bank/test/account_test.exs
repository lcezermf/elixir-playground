defmodule AccountTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = Account.start_link()

    %{pid: pid}
  end

  test "initial balance eq 0", %{pid: pid} do
    assert 0 == Account.get_balance(pid)
  end

  test "depositing money must change the balance by 10", %{pid: pid} do
    Account.deposit(pid, 10)

    assert 10 == Account.get_balance(pid)
  end

  test "withdraw money reduces balance by 5", %{pid: pid} do
    Account.withdraw(pid, 5)
    assert -5 == Account.get_balance(pid)

    Account.deposit(pid, 10)
    assert 5 == Account.get_balance(pid)

    Account.withdraw(pid, 5)
    assert 0 == Account.get_balance(pid)
  end
end
