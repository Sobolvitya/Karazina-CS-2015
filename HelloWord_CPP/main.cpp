// Делаем, чтом сообщение не пропадало сразу
#include <iostream> 

int main()
{
	std::cout << "Hello, World!" << std::endl; //+перевод на нновую строку
	std::cin.get(); // ждем Enter
}
