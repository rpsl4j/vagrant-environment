# Adding routes to a RIB in OpenDaylight Lithium
This guide roughly describes the process of adding routes to OpenDaylight Lithium's BGP speaker implementation via the RESTConf interface. This assumes that the OpenDaylight's BGP and RESTconf modules have been appropriately configured as described in the readme.

_please note the {{parameters}} in API URLs_  

## Retrieving Information
### View an RIB
To view information about an RIB including its tables:
__Method__: GET
__URL__: `http://localhost:8181/restconf/operational/bgp-rib:bgp-rib/rib/{{NAME-OF-RIB}}/`

### View a routing table
To view the routes currently occupying a particular table of an RIB
__Method__: GET
__URL__:` http://localhost:8181/restconf/operational/bgp-rib:bgp-rib/rib/{{rib-id}}/loc-rib/tables/bgp-types:{{AFI}}/bgp-types:{{SAFI}}/`

_default AFI and SAFI should be _`ipv4-address-family`_ and _`unicast-subsequent-address-family`_ respectively._

### Check which modules are loaded
__Method__: GET
__URL__:` http://127.0.0.1:8181/restconf/config/network-topology:network-topology/topology/topology-netconf/node/controller-config/yang-ext:mount/config:modules/`

## Injecting routes
### Adding routes to a Peer RIB
You cannot directly add routes to a BGP Peer's RIB ([source]( https://wiki.opendaylight.org/view/BGP_LS_PCEP:Restconf#Route_Information_Base_.28RIB.29)) as they do not support any sort of POST action. You must configure an Application Peer targeting the peers RIB and POST routes via it.

### Application Peers
An application peer emulates the behavior of a remote BGP speaker peering with OpenDaylight. They are used by adding routes to them which are then "peered" with the actual OpenDaylight BGP speaker instance. Any route added to the RIB of an application peer will be "copied" to the configured target RIB. Read more at the OpenDayight [wiki](https://wiki.opendaylight.org/view/BGP_LS_PCEP:Programmer_Guide#Inserting_routes).

### Set the routes of an Application RIB table
Used to initially populate the RIB table
__Method__: POST
__URL__:`http://localhost:8181/restconf/config/bgp-rib:application-rib/{{NAME-OF-APP-RIB}}/tables/bgp-types:{{AFI}}/bgp-types:{{SAFI}}/`
__Content-Type__: `application/xml`
__Body__ :
```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<ipv4-routes xmlns="urn:opendaylight:params:xml:ns:yang:bgp-inet">
 <ipv4-route>
  <prefix>200.20.160.1/32</prefix>
  <attributes>
   <ipv4-next-hop>
    <global>199.20.160.41</global>
   </ipv4-next-hop><as-path/>
   <multi-exit-disc>
    <med>0</med>
   </multi-exit-disc>
   <local-pref>
    <pref>100</pref>
   </local-pref>
   <originator-id>
    <originator>41.41.41.41</originator>
   </originator-id>
  <origin>
    <value>igp</value>
   </origin>
   <cluster-id>
    <cluster>40.40.40.40</cluster>
   </cluster-id>
  </attributes>
 </ipv4-route>
</ipv4-routes>
```

### Adding or updating a route in an Application RIB table
__Method__: PUT
__URL__:`http://localhost:8181/restconf/config/bgp-rib:application-rib/{{NAME-OF-APP-RIB}}/tables/bgp-types:{{AFI}}/bgp-types:{{SAFI}}/`
__Content-Type__: `application/xml`
__Body__: Same as POST equivilant

### Drop all routes in an Application RIB table
__Method__: DELETE
__URL__:`http://localhost:8181/restconf/config/bgp-rib:application-rib/{{NAME-OF-APP-RIB}}/tables/bgp-types:{{AFI}}/bgp-types:{{SAFI}}/`
__Content-Type__: `application/xml`
