# Защита от атаки SYN Flood

Программа реализует систему защиты от syn flood атаки.
На данный момент реализовано следующее:
  1. Загрузчик программы для исполнения на вирутальной машине eBPF из объектного файла;
  2. Вычисление хэша для формирования куки с последующим сохранением его в хэш таблицу;
  3. Основной код программы на данном этапе позволяет провести предварительнюу обработку приходящих пакетов с отбрасыванием всех, которые не подходят под заданные параметры или являются не корректными;
  4. Также реализована обработка ситуации, когда приходит SYN пакет с дальнейшей реализацией 2го пунта.

