class Target < ISM::Software

    def configure
        super

        if option("Pass1")
            configureSource([   "--prefix=#{Ism.settings.rootPath}/usr",
                                "--host=#{Ism.settings.target}",
                                "--build=$(build-aux/config.guess)",
                                "--disable-static",
                                "--docdir=#{Ism.settings.rootPath}/usr/share/doc/xz-5.2.5"],
                                buildDirectoryPath)
        else
            configureSource([   "--prefix=/usr",
                                "--disable-static",
                                "--docdir=/usr/share/doc/xz-5.2.5"],
                                buildDirectoryPath)
        end
    end

    def build
        super

        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super

        if option("Pass1")
            makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
        else
            makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        end
    end

end
