#ifndef {{ cls.name|upper }}_H
#define {{ cls.name|upper }}_H

#include <QtCore>

class {{ cls.name }} : public {{ cls.base }}
{
    Q_OBJECT

{% for prop in cls.props %}
    Q_PROPERTY({{ prop.type }} {{ prop.name }}{% if prop.read %} READ {{ prop.name }}{% endif %}{% if prop.write %} WRITE set{{ prop.name|firstUpper }}{% endif %}{% if prop.notify %} NOTIFY {{ prop.name }}Changed{% endif %})
{% endfor %}

public:
    explicit {{ cls.name }}(QObject *parent = nullptr);

public slots:
    void sync();
    bool autoSync() const;
    void setAutoSync(bool autoSync);

public:
{% for prop in cls.props %}
    {{ prop.type }} {{ prop.name }}() const;
{% endfor %}

public slots:
{% for prop in cls.props %}
    void set{{ prop.name|firstUpper }}(const {{ prop.type }} &{{ prop.name }});
{% endfor %}

signals:
{% for prop in cls.props %}
    void {{ prop.name }}Changed();
{% endfor %}

private:
    QSettings m_settings;
    bool m_autoSync = true;
};

#endif // {{ cls.name|upper }}_H

