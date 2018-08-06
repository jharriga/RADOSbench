# RADOSbench
automates runs of rados bench
as listed in Chapter 9 of RHCS Admin Guide
https://access.redhat.com/documentation/en-us/red_hat_ceph_storage/3/html/administration_guide/benchmarking_performance

SCRIPTS:
  - runTEST.sh    creates the pool and runs the tests. Results are logged in RESULTS/<timestamped>.log
  - deletePool.sh    removes the pool (see vars.shinc for pool name)
  - vars.shinc    conatins variable settings, such as LOGFILE naming scheme and pool name
  
