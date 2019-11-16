#ifndef APPSETTINGS_H
#define APPSETTINGS_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>

/* Директивы имен таблицы, полей таблицы и базы данных */

#define TABLE                      "Settings"                  // Название таблицы
#define TABLE_BACKCOLOR            "BackgroundColor"           // Вторая колонка
#define TABLE_BACKIMAGE            "BackgroundImage"           // Третья колонка
#define TABLE_THEME                "Theme"                     // Четвертая колонка
#define TABLE_AUTONIGHTMODE        "AutoNight"                 // Пятая колонка
#define TABLE_MESSAGETEXTSIZE      "MessageTextSize"           // Шестая колонка
#define TABLE_LANGUAGE             "Lang"                      // Седьмая колонка

// Первая колонка содержит Autoincrement ID


class AppSettings : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString backgroundColor READ backgroundColor WRITE setBackgroundColor NOTIFY backgroundColorChanged)
    Q_PROPERTY(QString backgroundImage READ backgroundImage WRITE setBackgroundImage NOTIFY backgroundImageChanged)
    Q_PROPERTY(QString theme           READ theme           WRITE setTheme           NOTIFY themeChanged)
    Q_PROPERTY(bool    autoNight       READ autoNight       WRITE setAutoNight       NOTIFY autoNightChanged)
    Q_PROPERTY(int     messTextSize    READ messTextSize    WRITE setMessTextSize    NOTIFY messTextSizeChanged)
    Q_PROPERTY(QString language        READ language        WRITE setLanguage        NOTIFY languageChanged)


public:

    explicit AppSettings(QObject *parent = nullptr);
    ~AppSettings();

    void connectToDataBase();

    // ___________________________________Сеттеры___________________________________________________

    Q_INVOKABLE void setBackgroundColor(QString color){m_BackroundColor = color;
                                           updateTable("BackgroundColor",color);
                                           emit backgroundColorChanged();}

    Q_INVOKABLE void setBackgroundImage(QString src){m_BackgroundImage = src; updateTable("BackgroundImage",src);
                                        emit backgroundImageChanged();}

    Q_INVOKABLE void setTheme(QString theme){m_Theme = theme; updateTable("Theme",theme); emit themeChanged();}

    Q_INVOKABLE void setAutoNight(bool mode){m_AutoNightMode = mode; updateTable("AutoNight",mode);
                                emit autoNightChanged();}

    Q_INVOKABLE void setMessTextSize(int size){m_MessageTextSize = size; updateTable("MessageTextSize",size);
                                  emit messTextSizeChanged();}
    Q_INVOKABLE void setLanguage(QString language){m_Language = language; updateTable("Lang",language);
                                      emit languageChanged();}

    // _____________________________________Геттеры______________________________________________

    QString backgroundColor() {return m_BackroundColor;}
    QString backgroundImage() {return m_BackgroundImage;}
    QString theme()           {return m_Theme;}
    bool    autoNight()       {return m_AutoNightMode;}
    int     messTextSize()    {return m_MessageTextSize;}
    QString language()        {return m_Language;}


private:

    // _________Настройки цвета вида приложения, изображения, тема: Dark, Standart,______________
    // _______________________________языка приложения___________________________________________

    QString m_BackroundColor, m_BackgroundImage, m_Theme, m_Language;
    bool m_AutoNightMode;       // Мод вкл темную тему в ночное время
    int m_MessageTextSize;      // Размер сообщения в переписке
    QSqlDatabase db;


private:

    bool openDataBase();        // Открытие базы данных
    void closeDataBase();       // Закрытие базы данных
    bool createTable();         // Создание базы таблицы в базе данных
    bool initData();            // Инициализация переменных

signals:
    void backgroundColorChanged();
    void backgroundImageChanged();       // Сигналы, вызывающиеся
    void themeChanged();                 // при изменении определенных
    void autoNightChanged();             // настроек
    void messTextSizeChanged();
    void languageChanged();


public slots:
    bool insertIntoTable(const QVariantList &data);      // Добавление записей в таблицу
    bool insertIntoTable(const QString &backColor, const QString &backImg, const QString &theme,
                         const bool &nightModeAuto, const int &textSize, const QString &lang);

    bool updateTable(const QString &upColumn, const QString &upValue); // Изменение данных в таблице
    bool updateTable(const QString &upColumn, const int &upValue);

};

#endif // APPSETTINGS_H
