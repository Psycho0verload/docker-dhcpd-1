load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

@test "checking if container fails without --net=host option" {
  run docker exec dhcpd-without-net-host /bin/bash -c "ls -al"
  assert_failure
}
