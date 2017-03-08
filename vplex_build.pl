#!/usr/bin/perl

use strict;
use warnings;

while (<>) {
        #my ($array,$uid,$size,$name ) = $_ =~ /(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/;
        #my ($array,$uid,$size,$name,$cg,$sv ) = $_ =~ /(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/;
        #my ($array,$uid,$size,$name,$cg ) = $_ =~ /(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/;
        my ($array,$uid,$size,$name,$sv ) = $_ =~ /(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/;
        print "cd /clusters/cluster-1/storage-elements/storage-volumes\n";
        print "storage-volume claim --storage-volumes $uid\n";
        my $long_name = "${array}_${name}";
        print "set ${uid}::name ${long_name}\n";
        print "cd /clusters/cluster-1/storage-elements/extents\n";
        print "extent create -d $long_name\n";
        print "set extent_${long_name}_1::name extent_${long_name}\n";
        print "local-device create --name device_${name} --geometry raid-0 --extents /clusters/cluster-1/storage-elements/extents/extent_${array}_${name}\n";
        print "virtual-volume create --device /clusters/cluster-1/devices/device_${name}\n";
        print "export storage-view addvirtualvolume --view $sv --virtual-volumes device_${name}_vol\n";
        #print "cd /clusters/cluster-1/consistency-groups/\n";
        #print "consistency-group create -n $cg -c cluster-1\n";
        #print "add-virtual-volumes --virtual-volumes device_${name}_vol --consistency-group $cg\n";
        #print "set /clusters/cluster-1/consistency-groups/${cg}::recoverpoint-enabled true\n";
        print "\n";
}
