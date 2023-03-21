class Target < ISM::Software

    def build
        super
        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource(["prefix=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}usr","install"],buildDirectoryPath)
    end

    def clean
        super
        deleteFile("#{Ism.settings.rootPath}/usr/lib/libzstd.a")
    end

end
