## Hadoop, установка

### Вариант 1 - собрать Hadoop из исходников. 

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

### Вариант 2 - поставить виртуальную машину. 

От Cloudera [www.cloudera.com](http://www.cloudera.com/downloads/quickstart_vms/5-5.html#)
или Hortonworks [www.hortonworks.com](http://hortonworks.com/products/hortonworks-sandbox/#install). 

Это два самые популярные коробочные решения для Hadoop, доступны образы для VMWare или Oracle ViirtualBox. В обоих случаях сказано, что на виртуальную машину нужно выделить 4GB памяти, соответственно у меня ни один из вариантов не запустился. Хотя [здесь](https://beyondparadiseblog.wordpress.com/2013/09/04/installing-cloudera-quickstart-vm-with-virtalbox-on-mac-step-by-step/), например, вроде как ставят виртуалку на Мак с 2GB оперативки, выделяя на виртуальную машину 1GB.

### Вариант 3 - Hadoop из jar архива (получилось). 

Установка согласно вот этому описанию: [Tutorial](http://v-lad.org/Tutorials/Hadoop/03%20-%20Prerequistes.html). Качаете jar архив и запускаете его через особым образом сконфигурированный CygWin (шелл Линукса под Windows). Несколько замечаний:

- для корректной работы надо чтоб была прописана переменная окружения JAVA_HOME, у меня C:\Java\jdk1.8.0_74 (без \bin) в конце. Важно, чтоб путь не содержал пробелов, поэтому если у вас Java установлена в Program Files, то теоретически можно прописать в переменно Progra~1, но лучше переустановить.
- в туториале описывается интеграция Hadoop с Eclipse, но если собственно интеграция не нужна, то шаги связанные с установкой и настройкой Eclipse можно пропустить, Hadoop будет работать и сам по себе.
- в туториале используется Hadoop версии 0.19.1 - достаточно старой. Вероятно все заработает и с последней версией, но я не пробовал.
- по сравнению с установкой, описанной на сайте Хадупа, обращения выглядят немного иначе, в частнности команды ддля файловой системы в туториале начинаются с `hadoop fs`, на сайте - с `hdfs`.

Документация по командам hdfs находится на сайте [Apache](https://hadoop.apache.org/docs/r2.4.1/hadoop-project-dist/hadoop-common/FileSystemShell.html). Небольшой гайд по типичному использованию навскидку нашелся на сайте [Hortonworks](http://hortonworks.com/hadoop-tutorial/using-commandline-manage-files-hdfs/). 

Результат работающей hdfs ориентировочно такой:

![Happy Hadooping](https://github.com/BChornomaz/Karazina-CS-2015/blob/master/Hadoop/HapppyHadooping.jpg)



### Сроки
Изначально я планировал 2 недели на установку, т.е. до 26.02, но т.к. установить пока не получается, я этот срок расшию на неделю и буду ориентироваться на 04.03. Установить Hadoop удалось, к 04.03 придумаю собственно задание и форму сдачи.  

График встреч, как мы с вами договаривались, раз в две недели с каждой группой, чередуя четверги и пятницы.

- 26.02, Пятница
- 03.03, Четверг
- 11.03, Пятница
- 17.03, Четверг
- 25.03, Пятница
- 31.03, Четверг

