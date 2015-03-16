export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=256m"
for i in affinity bgpcep controller lispflowmapping openflowjava openflowplugin ovsdb/commons/parent vtn yangtools integration
do (cd "$i" && mvn install -DskipTests -Dcheckstyle.skip=true); done
