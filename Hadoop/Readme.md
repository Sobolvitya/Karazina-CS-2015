## Hadoop, установка

### Вариант 1 - поставить Hadoop локально. 

Для Линукса описано здесь [HadoopInstal](http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SingleCluster.html), для Windows здесь [HadoopOnWindows](http://wiki.apache.org/hadoop/Hadoop2OnWindows). Под Линукс я ставить не пробовал, поэтому все дальнейшее относится к установке под Windows.

Подразумевается, что Hadoop собирается из исходников при помощи Maven. Перед сборкой рекоменддуется ознакомиться с требованиями к установке [building.txt](https://svn.apache.org/viewvc/hadoop/common/branches/branch-2/BUILDING.txt?view=markup). Без них действительно не собирается.

После сборки конфигурация осуществляется ссогласно части 3 в документе [HadoopOnWindows](http://wiki.apache.org/hadoop/Hadoop2OnWindows) и включае в себя настройку конфигурационных файлов, создание нового раздела HDFS (Hadoop Distributed File System), запуск демонов и наконец собственно тестовую операцию по помещению файла в hdfs. Вуглядеть это должно примерно так

```
C:\deploy>%HADOOP_PREFIX%\bin\hdfs dfs -put myfile.txt /

C:\deploy>%HADOOP_PREFIX%\bin\hdfs dfs -ls /
Found 1 items
drwxr-xr-x   - username supergroup          4640 2014-01-18 08:40 /myfile.txt

C:\deploy>
```

Следует заметить, что у меня собрать Hadoop таким образом так и не получилось.

Есть еще некий туториал по сборке [Tutorial](http://v-lad.org/Tutorials/Hadoop/03%20-%20Prerequistes.html), я его в ближайшее время попробую.

### Вариант 2 - поставить виртуальную машину. 

От Cloudera [www.cloudera.com](http://www.cloudera.com/downloads/quickstart_vms/5-5.html#)
или Hortonworks [www.hortonworks.com](http://hortonworks.com/products/hortonworks-sandbox/#install). 

Это два самые популярные коробочные решения для Hadoop, доступны образы для VMWare или Oracle ViirtualBox. В обоих случаях сказано, что на виртуальную машину нужно выделить 4GB памяти, соответственно у меня ни один из вариантов не запустился. Хотя [здесь](https://beyondparadiseblog.wordpress.com/2013/09/04/installing-cloudera-quickstart-vm-with-virtalbox-on-mac-step-by-step/), например, вроде как ставят виртуалку на Мак с 2GB оперативки, выделяя на виртуальную машину 1GB.

### Сроки
Изначально я планировал 2 недели на установку, т.е. до 26.02, но т.к. установить пока не получается, я этот срок расшию на неделю и буду ориентироваться на 04.03. Надеюсь что к этому времени базовую конфигуррацию получится завести, и тогда я уже собственно придумаю каких-нибудь лабораторок на эту тему.  

