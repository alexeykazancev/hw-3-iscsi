в дз требуется:развернуть в VirtualBox следующую конфигурацию с помощью terraform

виртуалка с iscsi
3 виртуальные машины с разделяемой файловой системой GFS2 поверх cLVM
должен быть настроен fencing для VirtualBox - https://github.com/ClusterLabs/fence-agents/tree/master/agents/vbox
для сдачи
terraform манифесты
ansible роль
README file



в данном репозитории я пробую развернуть машину на kvm гипервизоре, т.к на виртуалбоксе на локальном компьютере у меня не получилось этого сделать

1. для выполнения манифестов требуется скачать и установить бинарник тераформ
2. Для того, чтобы провайдеры корректно инизиализировались, необходимо создать в корне домашней директории файл с именем .terraformrc со следующим содержимым:

provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
} 

3. далее создаем файлы versions.tf  provider.tf  variables.tf  terraform.tfvars main.tf  outputs.tf

в файле versions.tf хранится информация об используемых провайдерах
в файле provider.tf описываются параметры провайдеров
в файле variables.tf описываются переменные, используемые в проекте
в файле terraform.tfvars присваиваем свои значения переменным.
в файле main.tf сперва создаем storage pool , затем в созданный пул мы загрузим облачный образ операционной системы, из этого образа мы создаем диск для виртуальной машины нужного нам размера, и в секции resource "libvirt_domain" мы создаем машину
для создания учетных записей и сетевых настроек мы создаем файлы cloud_init.cfg  и  network_config.cfg
в секции resource "libvirt_cloudinit_disk" "commoninit" создаем ресурс, выступающий в качестве диска, с которого будет браться конфигурация cloud-init при запуске виртуальной машины

в файле output.tf мы запрашиваем данные для подключения к вм после создания.

4. процедура разворачивания:
запускаем загрузку модулей terraform init
проверяем манифесты terraform validate
проверяем , что будет создано terraform plan
запускаем создание вм terraform apply